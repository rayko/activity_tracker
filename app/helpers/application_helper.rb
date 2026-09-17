module ApplicationHelper
  def month_name(date)
    date.strftime("%B")
  end

  def blue_btn_class
    "cursor-pointer block bg-linear-to-t from-sky-700 to-blue-400 text-gray-200 font-bold outline-indigo-300 w-full p-2 hover:shadow-lg/35 hover:shadow-gray-800 text-shadow-md/30"
  end

  def regular_btn_class
    "cursor-pointer block text-center mx-2 rounded-md bg-linear-to-t from-sky-700 to-blue-400 text-gray-200 font-bold outline-indigo-300 px-3 py-1 hover:outline-2 hover:outline-sky-500 text-shadow-md/30"
  end

  def regular_red_btn_class
    "cursor-pointer block text-center mx-2 rounded-md bg-linear-to-t from-red-700 to-red-400 text-gray-200 font-bold outline-red-300 px-3 py-1 hover:outline-2 hover:outline-red-500 text-shadow-md/30"
  end

  def link_to_back
    link_to "Back", :back, class: "block mx-2 text-sky-500 px-3 py-1 hover:underline"
  end

  def login_link_btn(text, target)
    content_tag(:div, class: "my-4 w-full text-center") do
      link_to text, target, class: blue_btn_class
    end
  end

  def box_container(&block)
    content_tag(:div, class: "text-sm md:text-md md:w-150 bg-gray-200 m-auto rounded-md shadow-lg/30 text-center") do
      yield
    end
  end
end
