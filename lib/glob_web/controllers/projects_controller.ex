defmodule GlobWeb.ProjectController do
  use GlobWeb, :controller

  alias Glob.Repo
  alias Glob.Project
  alias GlobWeb.Router.Helpers, as: Routes

  def index(conn, _params) do
    render(conn, "index.html", projects: Repo.all(Project))
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"project" => %{"name" => name, "description" => description}}) do
    project = %Project{name: name, description: description}
    case Project.changeset(project) do
      nil ->
        project = Repo.insert(project)
        render conn, "show.html", project: project
      errors ->
        render conn, "new.html", project: project, errors: errors
    end
  end

  def edit(conn, %{"id" => id}) do
    case Repo.get(Project, id) do
      project when is_map(project) ->
        render conn, "edit.html", project: project
      _ ->
        redirect conn, to: Routes.page_path(conn, :show, "unauthorized")
    end
  end

  def update(conn, %{"id" => id, "project" => params}) do
    project = Repo.get(Project, id)
    project = %{project | content: params["content"]}

    case Project.changeset(project) do
      nil ->
        Repo.update(project)
        # [g] really hacky way to redirect in the client.. (is there a better way?)
        conn
        |> put_status(201)
        |> json %{location: Routes.project_path(conn, :show, project.id) }
      errors ->
        json conn, errors: errors
    end
  end

  def destroy(conn, %{"id" => id}) do
    project = Repo.get(Project, id)
    case project do
      project when is_map(project) ->
        Repo.delete(project)
        conn
        |> put_status(201)
        |> json %{location: Routes.project_path(conn, :index)}
      _ ->
        redirect conn, Routes.page_path(page: "unauthorized")
    end
  end
end
