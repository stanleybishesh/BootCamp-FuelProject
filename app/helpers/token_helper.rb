module TokenHelper
  def current_entity_from_token
    token = request.headers["Authorization"].to_s.split(" ").last
    return unless token

    decoded_token = JWT.decode(token, "secret", true, algorithm: "HS256")[0]
    entity_type = decoded_token["type"]

    decoded_token["type"] == "user" && decoded_token["user_id"]

    if entity_type == "user" && decoded_token["user_id"]
      user = User.find_by(id: decoded_token["user_id"])
      return user if user&.jti == decoded_token["jti"]
    elsif entity_type == "courier" && decoded_token["courier_id"]
      courier = Courier.find_by(id: decoded_token["courier_id"])
      return courier if courier&.jti == decoded_token["jti"]
    end

    nil
  end
end
