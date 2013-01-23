# -*- encoding : utf-8 -*-
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
<% unless options[:singleton] -%>
  def index
    @search = <%= class_name %>.search(params[:q])
    @<%= table_name %> = @search.result(:distinct => true).paginate(:page => params[:page])
    respond_with(@<%= table_name %>)
  end
<% end -%>

  def show
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with(@<%= file_name %>)
  end

  def new
    @<%= file_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= file_name %>)
  end

  def edit
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= file_name %> = <%= orm_class.build(class_name, "params[:#{file_name}]") %>
    @<%= orm_instance.save %>
    respond_with(@<%= file_name %>)
  end

  def update
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.update_attributes("params[:#{file_name}]") %>
    respond_with(@<%= file_name %>)
  end

  def destroy
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
    respond_with(@<%= file_name %>)
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def <%= "#{singular_table_name}_params" %>
        params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes.map {|a| ":#{a.name}" }.sort.join(', ') %>)
    end
end
<% end -%>
