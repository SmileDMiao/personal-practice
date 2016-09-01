module NodesHelper

  #节点链接
  def render_node_name(name, id)
    link_to(name, node_articles_path(id))
  end

end
