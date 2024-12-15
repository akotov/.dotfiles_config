require('gen').prompts = {
  -- text operations
  ai_text_synonyms = {
    prompt =
    "Provide in a list form synonyms for the whole text: \n$text",
    replace = false,
  },
  ai_text_define_as_one_word = {
    prompt =
    "Provide in a list form. Define as a one word the whole text: \n$text",
    replace = false,
  },
  ai_text_spelling = {
    prompt =
    "Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n$text",
    replace = false,
  },
  ai_text_wording = {
    prompt =
    "Modify the following text to use better wording, just output the final text without additional quotes around it:\n$text",
    replace = false,
  },
  ai_text_concise = {
    prompt =
    "Modify the following text to make it as simple and concise as possible, just output the final text without additional quotes around it:\n$text",
    replace = false,
  },
  -- code operations
  ai_code_review = {
    prompt = "Review the following code and make concise suggestions:\n```$filetype\n$text\n```",
  },
  ai_code_enhance = {
    prompt =
    "Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = false,
    extract = "```$filetype\n(.-)```",
  },
  ai_code_change = {
    prompt =
    "Regarding the following code, $input, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = false,
    extract = "```$filetype\n(.-)```",
  },
  -- render in format
  ai_render_json = {
    prompt = "Render the following text in json format:\n$text",
    replace = false,
  },
  ai_render_csv = {
    prompt = "Render the following text in csv format:\n$text",
    replace = false,
  },
  ai_render_markdown_list = {
    prompt = "Render the following text as a markdown list:\n$text",
    replace = false,
  },
  ai_render_markdown_table = {
    prompt = "Render the following text as a markdown table:\n$text",
    replace = false,
  },
}
