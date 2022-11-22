class ProductionsController < ApplicationController

    wrap_parameters format: []

    def index 
        render json: Production.all, status: :ok
    end

    def show 
        production = Production.find_by(id: params[:id])

        # if production is present
        if production
            render json: production, status: :ok
        else
            render json: {error: "production not found"}, status: :not_found
        end
    end

    def create
        render json: Production.create(production_params), status: :created
    end

    private

    # get specific parameters from the production object
    def production_params
        params.permit(:title, :genre, :budget, :image, :director, :ongoing, :description)
    end
end