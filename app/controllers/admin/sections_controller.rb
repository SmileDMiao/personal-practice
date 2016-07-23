module Admin
  class SectionsController < Admin::ApplicationController

    def index
      @sections = Section.all
    end

    def new
      @section = Section.new()
    end

    def create
      @section = Section.new(permit_params)

      if @section.save
        redirect_to(admin_sections_path, notice: 'Section was successfully created.')
      else
        render action: "new"
      end
    end

    def destroy
      @section = Section.find(params[:id])
      @section.destroy

      redirect_to(admin_sections_path, notice: 'Section was successfully deleted.')
    end

    def show

    end

    def edit
      @section = Section.find(params[:id])
    end

    def update
      @section = Section.find(params[:id])

      if @section.update_attributes(permit_params)
        redirect_to(admin_sections_path, notice: 'Post was successfully updated.')
      else
        render action: "edit"
      end
    end


    private
    def permit_params
      params.require(:section).permit!
    end

  end
end