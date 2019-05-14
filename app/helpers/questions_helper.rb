module QuestionsHelper
  def question_type(t)
    t =~ /^(\w+)Question$/ 
    $1.downcase
  end

  def question_types
    %w{MultiChoiceQuestion NumericQuestion FreeResponseQuestion}
  end

  def question_input(q, currresponse)
    curr = currresponse ? currresponse.response : ""
    case q.type
      when "MultiChoiceQuestion"
        s = ""
        q.qcontent.each do |opt|
          s += label_tag(opt)
          h = {}
          # FIXME: doesn't work
          if opt==curr 
            h[:checked]='checked'
          end
          s += radio_button_tag('response', opt, **h)
        end
        s.html_safe
      when "NumericQuestion"
        number_field_tag :response, curr, :step => 0.01
      when "FreeResponseQuestion"
        text_field_tag :response, curr
    end
  end

  def show_image(img)
    if img.attached?
      image_tag(img.variant(resize: "100x100^")).html_safe
    end
  end
end
