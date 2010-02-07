require 'format_independent_textfile'

describe FormatIndependentTextfile do
  before do
    File.should_not exist "test.text"
    File.should_not exist "test.markdown"
    File.should_not exist "test.textile"
  end

  after do
    `rm test.*` 
  end

  it "should act like a file" do
    fname = "test.text"
    FormatIndependentTextfile.open(fname, "w") do |f|
      f << "here is some text"
    end

    File.should exist fname
    File.read(fname).should == "here is some text"
    
  end

  it "should return textile" do
    markdown_file = FormatIndependentTextfile.open("test.markdown", "w+")

    markdown_file << "# this is a heading\n"
    markdown_file << "## this is a second level heading\n"

    markdown_file.textile

    markdown_file.textile.should == <<EOS
h1. this is a heading
h2. this is a second level heading
EOS
  end
end