local M = {}

M.is_active = os.getenv("UWSM_ACTIVE") ~= nil

function M.wrap(cmd)
    if M.is_active then
        return "uwsm app -- " .. cmd
    end
    return cmd
end

return M
