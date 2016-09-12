module Admin
  class NodesController < Admin::ApplicationController

    def index
      @nodes = Node.includes(:section).page(params[:page]).per(10).order(:section_id)
      respond_to do |format|
        format.html # index.html.erb
        format.js
      end
    end

    def new
      @node = Node.new()
    end

    def create
      @node = Node.new(permit_params)

      if @node.save
        redirect_to(admin_nodes_path, notice: 'Section was successfully created.')
      else
        render action: "new"
      end
    end

    def destroy
      @node = Node.find(params[:id])
      @node.destroy

      redirect_to(admin_nodes_path, notice: 'Section was successfully deleted.')
    end

    def show

    end

    def edit
      @node = Node.find(params[:id])
    end

    def update
      @node = Node.find(params[:id])

      if @node.update_attributes(permit_params)
        redirect_to(admin_nodes_path, notice: 'Post was successfully updated.')
      else
        render action: "edit"
      end
    end


    private
    def permit_params
      params.require(:node).permit!
    end

  end
end