class Object
  def if_nil_then(x)
    if nil?
      x
    else
      self
    end
  end
end

module Make
  # takes as input, the contents of a makefile, produces an ast of it
  # @param [String] input
  def self.parse(input)
    input.split("\n").reduce([]) do |memo, line| 
      if line.start_with?("\t")
        memo.last[:commands].push(line.strip)
      elsif line != ""
        parts = line.split(":", 2)
        deps = parts[1] ? parts[1].split(" ") : []
        memo.push(make_rule(parts.first, deps, []))
      end
      memo
    end
  end

  def self.make_rule(target, prerequisites, commands)
    {:target => target, :prerequisites => prerequisites, :commands => commands, :built => false}
  end

  def self.need_to_build(dependencies, target)
    return true if !File.exist?(target)
    targetTime = File.mtime(target)
    return dependencies.any? { |dependency| targetTime <= File.mtime(dependency) }
  end

  # takes an ast of a makefile, target to build (nil means first), and executes commands in the correct order
  # @param [Array of Hash] rules
  # @param [String] goal
  def self.execute(rules, goal = nil)
    goal ||= rules.first[:target]
    rules_hash = Hash[rules.map { |rule| [rule[:target], rule] }]
    build_target(rules_hash, rules_hash[goal])
  end

  def self.build_target(rules_hash, goal)
    return if goal[:built] || !need_to_build(goal[:prerequisites], goal[:target])

    goal[:built] = true
    goal[:prerequisites].each { |prerequisite| build_target(rules_hash, rules_hash[prerequisite]) }
    goal[:commands].each { |command| raise "Failed to run: #{command}" unless system(command) }
  end

  # function that reads a file, parses it, and executes it.
  def self.driver(input, goal = nil)
    rules = parse(input)
    execute(rules, goal)
  end

end

if __FILE__ == $0
  Make.driver(File.open("Makefile", "r") { |f| f.read }, ARGV[0])
end
