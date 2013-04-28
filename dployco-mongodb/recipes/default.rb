include_recipe "mongodb::10gen_repo"
include_recipe "mongodb::default"

mongodb_instance "mongodb" do
  port node['dployco']['mongodb']['port']
end
