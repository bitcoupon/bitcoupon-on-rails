##
# Extends the rake doc:app task for generating documentation
# The task is guaranteed to run in the root path of
# the project, so it is okey to use relative paths.
#
# This task moves the default rails_project_root/doc/app folder
# to our chosen location of project_root/documentation/backend/app
#
# Anything previously in project_root/documentation/backend/app
# gets overwritten.
#

namespace :doc do
  task :app do
    puts "Documentation created in #{`pwd`.chomp}/doc/app"
    `rm -r ../documentation/admin/app`
    `mv doc/app ../documentation/admin`
    puts 'Documentation moved to '\
      "#{`pwd`.split(/\//)
                 .reverse
                 .drop(1)
                 .reverse
                 .join('/')
    }" +
    '/documentation/admin'
    `rmdir doc`
    puts 'Removed doc from admin'
  end

  task :tests do
    `mv coverage ../test_reports/admin_coverage`
  end
end
