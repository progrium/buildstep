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

Given /^a "(\w+)" application image exists$/ do |app_name|
  begin
    Docker::Image.get(app_name)
  rescue Docker::Error::NotFoundError
    steps %Q(Given I deploy a "#{app_name}" application)
    Docker::Image.get(app_name)
  end
end

Then /^a "(\w+)" application image should exist$/ do |app_name|
  Docker::Image.get(app_name)
end

Then /^it should successfully respond to web requests$/ do
  1.upto(5) do
    begin
      Excon.get("http://#{@container.json['NetworkSettings']['IPAddress']}:5000", expects: [200], idempotent: true, retry_limit: 10)
      break
    rescue Excon::Errors::SocketError
      sleep 2
    end
  end
end

Then /^shutdown cleanly$/ do
  if @container
    @container.stop
    @container.delete
  end
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

When /^I start the "(\w+)" application$/ do |app_name|
  steps %Q(Given no old "#{app_name}" containers exist)
  @container = Docker::Container.create('Cmd' => ['/start', 'web'], 'Image' => app_name, 'Env' => ['PORT=5000'])
  @container.start
  sleep 2
  expect(@container.json['State']['Running']).to be_truthy
end
