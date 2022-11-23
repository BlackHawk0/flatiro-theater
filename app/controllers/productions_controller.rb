class ProductionsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_response
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
        production =  Production.create!(production_params)
        render json: production, status: :created

    # rescue ActiveRecord::RecordInvalid => invalid
    #     render json: {error: invalid.record.errors}, status: :unprocessable_entity
        # if production.valid?
        #     render json: production, status: :created
        # else
        #     render json: production.errors.full_messages
        # end
    end

    def update
        # find
        production = Production.find_by(id: params[:id])

        # update
        if production
            production.update(production_params)
            render json: production, status: :accepted
        else
            render json: {error: "No such production"}, status: :not_found
        end
    end

    def destroy
        # find
        production = Production.find_by(id: params[:id])
        if production
            production.destroy
            head :no_content
        else
            render json: {error: "No such production"}, status: :not_found
        end

    end

    private
    def render_unprocessable_entity(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end

    # get specific parameters from the production object
    def production_params
        params.permit(:title, :genre, :budget, :image, :director, :ongoing, :description)
    end
end
