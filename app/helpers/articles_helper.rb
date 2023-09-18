module ArticlesHelper
  include MarkdownHelper
  def prepare_article(markdown_text, images=nil)
    images = [] if images.nil?
    images.each_with_index do |image, i|
      # html_answer.gsub!(/#{image[:name]}/, image_tag(image[:url]))

      markdown_text.gsub!("<image-#{i+1}>", image)
    end

    markdown(markdown_text)
  end


end
