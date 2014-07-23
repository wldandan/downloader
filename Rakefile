require "bundler/gem_tasks"

  desc 'Reports differences between CloudFormation stack and local version of template'
  task :cloudformation, :stack_name, :template_path do |t, args|
    puts "Diff between #{args[:template_path]} and stack #{args[:stack_name]}"

    template_in_cf = REA::AWS::Diff::CloudFormationTemplate.from_stack(args[:stack_name])
    local_template = REA::AWS::Diff::CloudFormationTemplate.from_file(args[:template_path])

    diff = local_template.diff(template_in_cf)
    failure_message = "There are changes between template for #{args[:stack_name]} stack and #{args[:template_path]}"

    handle_diff(diff, failure_message, template_in_cf, local_template)
  end
