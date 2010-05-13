module TemplateHelper
  
  def template_select(template = nil, cat = "Dtemplate")
    options = ""
    for temp in eval("#{cat}.find(:all)")
      if dtemp != nil
        if temp.name == dtemp.name
          options += "<option selected=\"selected\" value='#{temp.id}'>"+temp.name+"</option> "
        else
          options += "<option value='#{temp.id}'>"+temp.name+"</option> "
        end
      else #slot == nil
        options += "<option value='#{temp.id}'>"+temp.name+"</option> "
      end
    end
    options
  end
  
end
