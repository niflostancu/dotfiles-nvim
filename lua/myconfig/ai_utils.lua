-- Utility LLM integration-related routines.
local M = {}

-- Formats an LLM message with workarounds for llama.cpp
M.llama_cpp_form_messages = function(self, messages)
    local system_content = {}
    local other_messages = {}
    -- 1. Separate system messages from everything else
    for _, msg in ipairs(messages) do
        if msg.role == "system" then
            table.insert(system_content, msg.content)
        else
            table.insert(other_messages, msg)
        end
    end
    local final_messages = {}
    -- 2. If there are system messages, merge them into ONE message at the top
    if #system_content > 0 then
        table.insert(final_messages, {
            role = "system",
            content = table.concat(system_content, "\n\n"),
        })
    end
    -- 3. Append all the user/assistant messages
    local last = nil
    for _, msg in ipairs(other_messages) do
        last = msg
        table.insert(final_messages, msg)
    end
    if last.role == "assistant" then
        table.insert(final_messages, { role = "user", content="" })
    end
    -- 4. Pass the cleaned messages to the standard OpenAI handler
    local openai = require "codecompanion.adapters.http.openai"
    return openai.handlers.form_messages(self, final_messages)
end

-- Further process llama.cpp response metadata
M.llama_cpp_parse_message_meta = function(self, data)
    local extra = data.extra
    if extra and extra.reasoning_content then
        data.output.reasoning = { content = extra.reasoning_content }
        if data.output.content == "" then
            data.output.content = nil
        end
    end
    return data
end

return M
