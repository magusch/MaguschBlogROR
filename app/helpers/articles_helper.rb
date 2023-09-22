module ArticlesHelper
  include MarkdownHelper
  def prepare_article(markdown_text, images=nil)
    images = [] if images.nil?
    images.each_with_index do |image, i|
      markdown_text.gsub!("<image-#{i+1}>", image)
    end

    markdown_text.gsub!(/<image-\d+>/, '')

    markdown(markdown_text)
  end


end
