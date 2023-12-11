-- Assurez-vous que 'nvim-notify' est installé et configuré correctement.
-- Ce script suppose que `nvim-notify` a été configuré pour remplacer `vim.notify`.

local api = vim.api
local loop = vim.loop

-- Crée un nouveau timer de boucle d'événements de Neovim
local timer = loop.new_timer()

-- Fonction pour revenir au mode normal
local function go_to_normal_mode()
	-- Vérifie si le mode actuel est le mode Insert
	if api.nvim_get_mode().mode == "i" then
		-- Envoie la touche <Esc> pour revenir au mode normal
		api.nvim_feedkeys(api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
		-- Affiche une notification
		vim.notify("normal mode", {
			title = "Mode Normal",
			timeout = 7000,
			-- Ici vous pouvez ajouter d'autres options de notification si nécessaire
		})
	end
end

-- Fonction pour démarrer ou redémarrer le timer
local function start_timer()
	timer:stop() -- Arrête le timer si déjà en cours pour éviter les doubles déclenchements
	timer:start(7000, 0, function()
		vim.schedule(go_to_normal_mode) -- Utilise vim.schedule pour appeler la fonction dans le thread principal de Neovim
	end)
end

-- Autocommand pour lancer le timer après chaque événement CursorHoldI
api.nvim_create_autocmd("CursorHoldI", {
	pattern = "*",
	callback = start_timer,
})

-- Il est important de nettoyer le timer lors de la fermeture de Neovim
api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	callback = function()
		timer:stop() -- Assurez-vous de stopper le timer pour nettoyer les ressources
	end,
})
