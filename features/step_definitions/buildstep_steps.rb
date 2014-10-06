Given /^no old "(\w+)" containers exist$/ do |app_name|
  begin
    cache = Docker::Container.get("cache_#{app_name}")
    cache.delete(force: true)
  rescue Docker::Error::NotFoundError
  end

  begin
    app = Docker::Container.get(app_name)
    app.delete(force: true)
  rescue Docker::Error::NotFoundError
  end
end

Then /^a "(\w+)" application image should exist$/ do |app_name|
  Docker::Image.get(app_name)
end

When /^I deploy a "(\w+)" application$/ do |app_name|
  steps %Q(
    Given no old "#{app_name}" containers exist
    When I successfully run `docker run -v '/cache' --name='cache_#{app_name}' busybox:latest true`
    And I successfully run `bash -c "tar -cC ../../features/apps/#{app_name} -f - . | docker run -i --volumes-from='cache_#{app_name}' --name='#{app_name}' progrium/buildstep bash -c 'mkdir -p /app && tar -xC /app && /build/builder'"`
    And I successfully run `docker commit '#{app_name}' '#{app_name}'`
    And I successfully run `docker rm '#{app_name}'`
  )
end
