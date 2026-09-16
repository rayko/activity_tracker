module FormBuilders
  # Common form builder to build most of them in the app, with the same baseline
  # styling.
  class Common < ActionView::Helpers::FormBuilder

    def text_field(method, options = {})
      opts = { class: _txt_class(method) }.merge(options)
      box_field_container(method) do
        @template.text_field(@object_name, method, objectify_options(opts))
      end
    end

    def text_area(method, options = {})
      opts = { class: _txt_class(method), rows: 3 }.merge(options)

      box_field_container(method) do
        @template.text_area(@object_name, method, objectify_options(opts))
      end
    end

    def submit(text, options = {})
      opts = { class: _submit_class }.merge(options)
      @template.submit_tag(text, objectify_options(opts))
    end

    # Helper to place a divider in the form
    def divider
      @template.content_tag(:hr, nil, class: "my-3 border-gray-400")
    end

    # Container for form buttons
    def buttons(&block)
      @template.content_tag(:div, class: "flex flex-row place-content-center") do
        yield
      end
    end

    def email_field(method, options = {})
      opts = { class: _txt_class }.merge(options)
      box_field_container(method) do
        @template.email_field(@object_name, method, objectify_options(opts))
      end
    end

    def password_field(method, options = {})
      opts = { class: _txt_class }.merge(options)
      box_field_container(method) do
        @template.password_field(@object_name, method, objectify_options(opts))
      end
    end

    private

    def field_errors?(method)
      @object.errors.select{ |err| err.attribute == method }.any?
    end

    def field_errors(method)
      messages = @object.errors.select{ |err| err.attribute == method }.map(&:message)
      return "" if messages.empty?

      @template.content_tag(:div, class: "text-red-500 italic px-4") do
        messages.join(', ')
      end
    end

    # Typical input with label and a box field (even text area)
    def box_field_container(method)
      @template.content_tag(:div, class: "flex flex-row my-5") do      
        input_label(method) +
        @template.content_tag(:div, class: "w-3/4") do
          output = yield
          output + field_errors(method)
        end
      end
    end

    def _submit_class
      "rounded-md bg-linear-to-t from-sky-700 to-blue-400 text-gray-200 font-bold outline-indigo-300 px-3 py-1 hover:outline-2 hover:outline-sky-500 text-shadow-md/30"
    end

    def _txt_class(method)
      css = %w[p-2 caret-black ml-3 border-1 rounded-md border-gray-600 bg-white w-3/4]
      css << (field_errors?(method) ? "border-red-600 focus:outline-red-400" : "border-gray-600")
      css.join(' ')
    end

    def input_label(method)
      @template.content_tag(:div, class: "w-1/4  p-2 text-right") do
        @template.label(@object_name, method)
      end
    end

  end
end
