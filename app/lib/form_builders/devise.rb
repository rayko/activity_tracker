module FormBuilders
  class Devise < ActionView::Helpers::FormBuilder

    def email_field(method, options = {})
      opts = {
        autofocus: true,
        autocomplete: "email",
        placeholder: "email...",
        class: _field_styling
      }.merge!(options)
      @template.content_tag(:div, class: _field_container_styling) do
        @template.email_field(@object_name, method, objectify_options(opts))
      end
    end

    def password_field(method, options = {})
      opts = {
        autocomplete: "password",
        placeholder: "password...",
        class: _field_styling
      }.merge!(options)
      @template.content_tag(:div, class: _field_container_styling) do
        @template.password_field(@object_name, method, objectify_options(opts))
      end
    end

    def remember_me_field(method, options = {})
      opts = {
        class: "px-0 mx-2"
      }.merge!(options)
      @template.content_tag(:div, class: _field_container_styling) do
        @template.check_box(@object_name, method, objectify_options(opts)) +
        @template.label(@object_name, method, class: "w-full")
      end
    end

    private

    def _field_container_styling
      "text-black p-1 w-full"
    end
    
    def _field_styling
      "text-black p-1 w-full bg-white outline-2 outline-gray-300 rounded-sm my-2 focus:outline-indigo-500 focus:outline-2 placeholder:italic placeholder:text-gray-400"
    end

  end
end
