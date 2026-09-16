module ApplicationHelper
  def blue_btn_class
    "block bg-linear-to-t from-sky-700 to-blue-400 text-gray-200 font-bold outline-indigo-300 w-full p-2 hover:shadow-lg/35 hover:shadow-gray-800 text-shadow-md/30"
  end

  def regular_btn_class
    "block text-center mx-2 rounded-md bg-linear-to-t from-sky-700 to-blue-400 text-gray-200 font-bold outline-indigo-300 px-3 py-1 hover:outline-2 hover:outline-sky-500 text-shadow-md/30"
  end

  def login_link_btn(text, target)
    content_tag(:div, class: "my-4 w-full text-center") do
      link_to text, target, class: blue_btn_class
    end
  end
end
