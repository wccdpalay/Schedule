module TemplateHelper
  
  def template_select(dtemp = nil)
    options = ""
    select_used = false
    for temp in Dtemplate.find(:all)
      if dtemp != nil
        if temp.name == dtemp.name
          select_used = true
          options += "<option selected=\"selected\" value='#{temp.id}'>"+temp.name+"</option> "
        else
          options += "<option value='#{temp.id}'>"+temp.name+"</option> "
        end
      else #slot == nil
        options += "<option value='#{temp.id}'>"+temp.name+"</option> "
      end
    end
    if select_used
      options = "<option value='nil'> - </option>" + options
    else
      options = "<option selected=\"selected\" value='nil'> - </option>" + options
    end
    options
  end
  
end
