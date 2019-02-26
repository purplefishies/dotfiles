#!/usr/bin/env ruby
# coding: utf-8
# Example prompts
#
# (master|✔) : on branch master everything uptodate
# (master↑3|+1): on branch master, ahead of remote by 3 commits, 1 file changed but not staged
# (status|⚬2): on branch status, 2 files staged
# (master|+7…): on branch master, 7 files changed, some files untracked
# (master|✗2+3): on branch master, 2 conflicts, 3 files changed
# (master|⚑2): on branch master, 2 stash entries
# (experimental🔃↓2↑3|✔): on branch experimental; your branch has diverged by 3 commits, remote by 2 commits; the repository is otherwise clean
# (experimental🔃↓2↑3): Don't want the clean ...only if there are differences
# (:70c2952|✔): not on any branch; parent commit has hash 70c2952; the repository is otherwise clean
# (master🔃↑3↓2)
# (master🔃↑3↓2|✗2✚3⚑2)


require 'yaml'

pipe = IO.popen("git status 2>/dev/null")

lines = pipe.readlines

files_modified=[]
files_unstaged=[]
files_untracked=[]
files_both_modified=[]
branch = nil
remote_branch = nil
i = 0

while i < lines.length
#for i in (0..lines.length-1)
  #puts "#{i} #{lines[i]}"
  #puts "#{i}"
  if (lines[i] =~ /On branch\s(\S+)/) != nil
    branch=$1
  end
  
  if (lines[i] =~ /Your branch is up-to-date with '(\S+?)'.*/) != nil
    remote_branch = $1
  end
  if (lines[i] =~ /Your branch is ahead of '(\S+)' by (\d+) commits.*/) != nil
    remote_branch = $1
    ahead = $2
  end
  if (lines[i] =~ /Your branch is behind '(\S+)' by (\d+) commits.*/) != nil
    remote_branch = $1
    behind= $2
  end
  if (lines[i] =~ /Unmerged paths:/) != nil
    #puts "#{lines[i]}"
    j = i+4
    #puts "#{lines[j]}"
    while (lines[j] =~ /^\s+both modified:\s+(\S+)/) != nil && ( lines[j] =~ /^\s*/) != nil
      files_both_modified.push($1)
      j+=1
    end 
  end
  
  if (lines[i] =~ /Your branch and (\S+) have diverged/ ) != nil
    remote_branch = $1
    lines[i+1] =~ /.*and have (\d+) and (\d+) different commits each.*/
    ahead = $1
    behind = $2
  end
  if (lines[i] =~ /^Changes to be committed.*/) != nil
    #puts "HERE"
    for j in i+1..lines.length-1
      #puts "\t#{lines[j]}"
      if lines[j] =~ /^[CU]/
        #puts lines[j]
        i = j-1
        break
      elsif lines[j] =~ /^\s+(?:modified|new file):\s+(\S+.*)/
        files_modified.push($1)
        #puts "#{$1}FOO"
      end
    end
  end
  if (lines[i] =~ /^Changes not staged for commit:/) != nil
    for j in i+1..lines.length-1
      if lines[j] =~ /^[CU]/
        #puts lines[j]
        i = j-1
        break
      elsif lines[j] =~ /^\s+(?:modified):\s+(\S+.*)/
        files_unstaged.push($1)
        #puts "#{$1}FOO"
      end
    end
  end
  if (lines[i] =~ /Untracked files:/ ) != nil
    for j in i+2..lines.length-1
      if lines[j] =~ /^no changes added/
        break
      elsif lines[j] =~ /^\s+(\S+.*)/
        files_untracked.push($1)
      end
    end
  end
  i += 1
end
stash = IO.popen("git stash list 2>/dev/null").readlines

print "GIT_STAGED=\"#{files_modified.length <= 0 ? "" : files_modified.length}\";"
print "GIT_UNSTAGED=\"#{files_unstaged.length <= 0 ? "" : files_unstaged.length}\";"
print "GIT_UNTRACKED=\"#{files_untracked.length <= 0 ? "" : files_untracked.length}\";"
print "GIT_BRANCH=\"#{branch}\";"
print "GIT_REMOTE_BRANCH=\"#{remote_branch}\";"
print "GIT_NUMBER_AHEAD=\"#{ahead}\";"
print "GIT_NUMBER_BEHIND=\"#{behind}\";"
print "GIT_BOTH_MODIFIED=\"#{files_both_modified.length <= 0 ? "" : files_both_modified.length}\";"
print "GIT_STASH=\"#{stash.length <= 0 ? "" : stash.length}\";\n";
