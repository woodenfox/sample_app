class Car2go
  
  @@consumer_key = "Car2Square"
  @@secret = "tZxa8ts1KFsjyyirNfEX"
  @@base_uri = "http://www.car2go.com/api/v2.1/"
  @@req_params = "?oauth_consumer_key=#{@@consumer_key}&format=json"

  def self.getRes(resource, params)
    url = @@base_uri + resource + @@req_params + params
    response = HTTParty.get(url)

    for i in 1..response["placemarks"].count
      llf = response["placemarks"][i]["coordinates"].first
      lls = response["placemarks"][i]["coordinates"].second
      if (-122.30850..-122.29974).member?(llf)
        if (47.63233..47.62517).member?(lls)
            puts response["placemarks"][i]
        end
      end 
    end
    #return response.body
  end
end

