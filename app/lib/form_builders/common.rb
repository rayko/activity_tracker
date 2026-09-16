module FormBuilders
  # Common form builder to build most of them in the app, with the same baseline
  # styling.
  class Common < ActionView::Helpers::FormBuilder

    def text_field(method, options = {})
      opts = { class: _txt_class }.merge(options)

      input_container do
        input_label(method) +
        @template.text_field(@object_name, method, objectify_options(opts))
      end
    end

    def text_area(method, options = {})
      opts = { class: _txt_class, rows: 3 }.merge(options)

      input_container do
        input_label(method) +
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
      input_container do
        input_label(method) +
        @template.email_field(@object_name, method, objectify_options(opts))
      end
    end

    def password_field(method, options = {})
      opts = { class: _txt_class }.merge(options)
      input_container do
        input_label(method) +
        @template.password_field(@object_name, method, objectify_options(opts))
      end
    end

    private

    def input_container(&block)
      @template.content_tag(:div, class: "flex flex-row my-5") do
        yield
      end
    end

    def _submit_class
      "rounded-md bg-linear-to-t from-sky-700 to-blue-400 text-gray-200 font-bold outline-indigo-300 px-3 py-1 hover:outline-2 hover:outline-sky-500 text-shadow-md/30"
    end

    def _txt_class
      "p-2 caret-black ml-3 border-1 rounded-md border-gray-600 bg-white w-2/4"
    end

    def input_label(method)
      @template.label(@object_name, method, class: "w-1/4  p-2 text-right")
    end


  end
end
