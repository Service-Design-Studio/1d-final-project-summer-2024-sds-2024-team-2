# app/models/interaction.rb
class InteractionHistory < ApplicationRecord
  belongs_to :ngo_user
  # other code related to the model
end
