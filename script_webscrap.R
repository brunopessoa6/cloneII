#httr 
#revest

library(tidyverse)
library(httr)
library(jsonlite)

playlists_id <- c("37i9dQZEVXbMDoHDwVN2tF",
                  "37i9dQZEVXbMZAjGMynsQX",
                  "37i9dQZEVXbMXbN3EUUhlg",
                  "37i9dQZEVXbLRQDuF5jeBp",
                  "37i9dQZEVXbJPcfkRz0wJ0",
                  "37i9dQZEVXbM8SIrkERIYl",
                  "37i9dQZEVXbLnolsZ8PSNw",
                  "37i9dQZEVXbIPWwFssbupI",
                  "37i9dQZEVXbJiZcmkrIHGU",
                  "37i9dQZEVXbMH2jvi6jvjk",
                  "37i9dQZEVXbKXQ4mDTEBXq",
                  "37i9dQZEVXbMnZEatlMSiu",
                  "37i9dQZEVXbLZ52XmnySJg")
playlists_country <- c("Global",
                       "Costa Rica",
                       "Brasil",
                       "EUA",
                       "Austrália",
                       "Nova Zelândia",
                       "Reino Unido",
                       "França",
                       "Alemanha",
                       "Africa do Sul",
                       "Japão",
                       "Taiwan",
                       "Índia")

playlists <- data.frame(id = playlists_id, country = playlists_country, stringsAsFactors = FALSE)

TOKEN <- "Bearer BQChlx0tjsSI5ZU3jQukB3KQH1-moiXU5LFWwlTWnvdq4q-Ub9VWBr2TxI2IzTO8z8T5sFvc_NFy5UoAc3s"

responsse_tracks <- GET('https://api.spotify.com/v1/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks', config = add_headers(Authorization = TOKEN))

response_tracks_parsed <- content(responsse_tracks, as = "text") %>% 
  fromJSON()

tracks_info <- response_tracks_parsed[['items']]$track                        

dados_tracks <- data.frame()
dados_tracks <- rbind(dados_tracks, data.frame(id = tracks_info$id, name = tracks_info$name, playlists = "Global", stringsAsFactors = FALSE))

#maravilhoso for

dados_tracks <- data.frame()
for (i in 1:nrow(playlists)){
  print(playlists$country[i])
  responsse_tracks <- GET( paste('https://api.spotify.com/v1/playlists/','/tracks', sep = playlists$id[i]), config = add_headers(Authorization = TOKEN))
  response_tracks_parsed <- content(responsse_tracks, as = "text") %>% 
    fromJSON()
    tracks_info <- response_tracks_parsed[['items']]$track                        
    dados_tracks <- rbind(dados_tracks, data.frame(id = tracks_info$id, name = tracks_info$name, playlists = playlists$country[i], stringsAsFactors = FALSE))
}

list_tracks_ids <- split(dados_tracks$id, ceiling(seq_along(dados_tracks$id)/50))

url_tracks 









