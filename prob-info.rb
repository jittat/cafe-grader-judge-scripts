require 'json'

problem_home = ARGV[0]

ENV['PROBLEM_HOME'] = problem_home

require_relative 'std-script/test_dsl.rb'
load "#{problem_home}/test_cases/all_tests.cfg"

problem = Problem.get_instance

num_runs = problem.runs.length - 1

res = {
  num_tests: problem.num_tests,
  num_runs: num_runs,
  tests: {},
  runs: {}
}

(1..(problem.num_tests)).each do |test_num|
  res[:tests][test_num] = {
    time_limit: problem.get_time_limit(test_num),
    mem_limit: problem.get_mem_limit(test_num) * 1024,
  }
end

(1..num_runs).each do |k|
  res[:runs][k] = {
    tests: problem.runs[k].tests,
    scores: problem.runs[k].scores,
  }
end

puts JSON.pretty_generate res, indent: "  "
