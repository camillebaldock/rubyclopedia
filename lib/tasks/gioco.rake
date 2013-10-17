# -*- encoding: utf-8 -*-
namespace :gioco do
  
  desc "Used to add a new badge at Gioco scheme"
  
  task :add_badge, [:name, :points, :kind, :default] => :environment do |t, args|
    arg_default = ( args.default ) ? eval(args.default) : false


    if !args.name || !args.points || !args.kind
      raise "There are missing some arguments"
    else
      badge_string = "kind = Kind.find_or_create_by_name('#{args.kind}')\n"

      badge_string = badge_string + "badge = Badge.create({ 
                      :name => '#{args.name}', 
                      :points => '#{args.points}',
                      :kind_id  => kind.id,
                      :default => '#{arg_default}'
                    })
"

      if arg_default
        badge_string = badge_string + 'resources = User.find(:all)
'
        badge_string = badge_string + "resources.each do |r|
        r.points  << Point.create({ :kind_id => kinds.id, :value => '#{args.points}'})
          r.badges << badge
          r.save!
        end
"
      end
      
      badge_string = badge_string + "puts '> Badge successfully created'"

      eval badge_string
      
      file_path = "/db/gioco/create_badge_#{args.name}_#{args.kind}.rb"
      File.open("#{Rails.root}#{file_path}", 'w') { |f| f.write badge_string }
      File.open("#{Rails.root}/db/gioco/db.rb", 'a') { |f| f.write "require \"\#\{Rails.root\}#{file_path}\"
" }

    end

  end

  desc "Used to remove an old badge at Gioco scheme"

  task :remove_badge, [:name, :kind] => :environment do |t, args|
    if !args.name || !args.kind
      raise "There are missing some arguments"
    else
      badge_string = "kind = Kind.find_by_name('#{args.kind}')
      badge = Badge.where( :name => '#{args.name}', :kind_id => kind.id ).first
      badge.destroy
"
    end

    badge_string = badge_string + "puts '> Badge successfully removed'"

    eval badge_string
    
    file_path = "/db/gioco/remove_badge_#{args.name}.rb"
    File.open("#{Rails.root}#{file_path}", 'w') { |f| f.write badge_string }
    File.open("#{Rails.root}/db/gioco/db.rb", 'a') { |f| f.write "require \"\#\{Rails.root\}#{file_path}\"
" }
  end

  desc "Removes a given kind"
  task :remove_kind, [:name] => :environment do |t, args|
    if !args.name
      raise "There are missing some arguments"
    else
      kind_string = "kind = Kind.find_by_name( '#{args.name}' )\n"
      kind_string = kind_string + "if kind.badges.empty?
        kind.destroy
      else
        raise 'Aborted! There are badges related with this kind.'
      end\n"
    end
    kind_string = kind_string + "puts '> Kind successfully removed'"
    eval kind_string
    
    file_path = "/db/gioco/remove_kind_#{args.name}.rb"
    File.open("#{Rails.root}#{file_path}", "w") { |f| f.write kind_string }
    File.open("#{Rails.root}/db/gioco/db.rb", "a") { |f| f.write "require \"\#\{Rails.root\}#{file_path}\"\n" }
  end
    
end
