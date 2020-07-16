# Custom ToggleInput for SimpleForm
class ToggleInput < SimpleForm::Inputs::BooleanInput

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    build_check_box(unchecked_value, merged_input_options)
  end

  def label_text(_wrapper_options = nil)
    switch_btn + label_html
  end

  private

  def label_html
    template.content_tag(:spen, class: 'switch-text') do
      label_text = options[:label_text] || SimpleForm.label_text
      label_text.call(html_escape(raw_label_text), required_label_text, options[:label].present?).
        strip.html_safe
    end
  end

  def switch_btn
    template.content_tag(:span, '', class: 'switch-btn')
  end

end
