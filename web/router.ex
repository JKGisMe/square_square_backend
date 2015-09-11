defmodule SquareSquareBackend.Router do
  use SquareSquareBackend.Web, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    SquareSquareBackend.DeserializePlug
  end

  scope "/", SquareSquareBackend do
    pipe_through :api

    resources "/squares", SquareController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SquareSquareBackend do
  #   pipe_through :api
  # end
end
