module ApplicationHelper

    #You can go back to "GRAVATAR" website to check how to use the API.
  def gravatar_for (chef, options = {size:80})
    #This is to get MD5 hash. You can test it in the console using a variable for the email
    gravatar_id = Digest::MD5::hexdigest(chef.email.downcase )
    size = options [:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: chef.chefname, class:"gravatar")
  end

  
end
