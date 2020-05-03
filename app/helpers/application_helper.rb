module ApplicationHelper
  def sortable(column, title=nil, query=nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: direction, query: query }
  end  
end
