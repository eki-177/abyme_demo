module ApplicationHelper

  def abymize(form, association, &block)
    content_tag(:div, data: { target: 'abyme.associations' }) do
      content_tag(:template, class: "abyme--#{formatize(association).singularize}_template", data: { target: 'abyme.template' }) do
        form.fields_for formatize(association), association, child_index: 'NEW_RECORD' do |f|
          content_tag(:div, class: 'abyme--fields') do
            render("#{formatize(association).singularize}_fields", f: f)
          end
        end
      end
    end
  end

  def abyme_records(form, association, options = { order: {} })

    if options[:collection]
      records = options[:collection]
    else
      records = form.object.send(association)
    end

    if options[:order].present?
      records = records.order(options[:order])
    end
    
    # GET INVALID RECORDS
    # invalids = form.object.send(association).reject(&:persisted?)
    
    # if invalids.any?
    #   records = records.to_a.concat(invalids)
    # end

    form.fields_for association, records do |f|
      content_tag(:div, class: 'abyme--fields') do
        render("#{association.to_s.singularize}_fields", f: f)
      end
    end
  end

  def abyme_for(association, position = :after, &block)
    content_tag(:div, data: { controller: 'abyme', abyme_position: position }) do
      capture(&block)
    end
  end

  def abyme_add_association(text, **options)
    button_tag(text, { data: { action: 'click->abyme#add_association' } }.merge(options))
  end

  def abyme_remove_association(text, **options)
    button_tag(text, { data: { action: 'click->abyme#remove_association' } }.merge(options))
  end

  def formatize(association)
    association.class.name.tableize
  end

end