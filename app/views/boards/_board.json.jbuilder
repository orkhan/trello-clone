json.extract! board, :id, :uid, :name, :created_at, :updated_at
json.lists board.lists do |list|
  json.(list, :id, :name, :created_at, :updated_at, :cards)
end