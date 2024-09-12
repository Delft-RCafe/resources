# Install packages --------------------------------------------------------
# install.packages("tidytuesdayR")
# install.packages("tidyverse")
# install.packages("lubridate")
# install.packages("wordcloud2")


# Load libraries ----------------------------------------------------------
library(tidyverse)
library(tidytuesdayR)
library(wordcloud2)
library(lubridate)

# Load data ---------------------------------------------------------------

tuesdata <- tt_load('2024-08-27')

tuesdata # get info about the challenge

power_rangers_episodes <- tuesdata$power_rangers_episodes
power_rangers_seasons <- tuesdata$power_rangers_seasons


# Explore datasets  -------------------------------------------------------

# First look at the data
power_rangers_episodes |> View()
glimpse(power_rangers_episodes)
summary(power_rangers_episodes)


# First look at the data
power_rangers_seasons |> View()
glimpse(power_rangers_seasons)
summary(power_rangers_seasons) # date of last episode as character

head(power_rangers_seasons$air_date_last_ep) # look at the date of last episode

power_rangers_seasons |> # look at the cat variable
  count(producer)

# Data cleaning -----------------------------------------------------------
power_rangers_seasons <- 
  power_rangers_seasons |>
  mutate(air_date_last_ep_date  = as_date(air_date_last_ep))

summary(power_rangers_seasons) # date of last episode as character


power_rangers_seasons|>
  filter(is.na(air_date_last_ep_date) )

power_rangers_seasons <-
  power_rangers_seasons |>
  mutate( air_date_last_ep_date = replace(air_date_last_ep_date,
                                          is.na(air_date_last_ep_date), 
                                          as_date("2022-01-01"))  )
summary(power_rangers_seasons) 


# Merge datasets ----------------------------------------------------------

# Change season dataset variable names

power_rangers_seasons <-  
  power_rangers_seasons |>
  rename(season_IMDB_rating = IMDB_rating)

# power_rangers_seasons <- power_rangers_seasons |>
#   rename_with(.fn = function(x){paste0("season_", x)},
#               .cols = !starts_with("season_") )


pr_df <- power_rangers_episodes |>
  full_join(power_rangers_seasons,  # we don't want to loose any information
             by = join_by(season_title)) 


# Set theme  & colors ---------------------------------------------------------------
theme_set( theme_minimal())

pr_cols <- c("red", "blue","yellow", "darkgreen","pink", "black", "white" )
pr_cols2 <- c("#D43CA0", "#DFAE15", "#0F9668", "#EE0707", "#3410F1", "#080808" )



# Season timeline ---------------------------------------------------------

p <- power_rangers_seasons |>
  ggplot() +
  geom_point(aes(x = season_title, y = air_date_first_ep )) 

p
# Season timeline - flip axes ---------------------------------------------------------

(p <- p +  coord_flip())

# Season timeline - add season number ---------------------------------------------------------

p <- power_rangers_seasons |>
  mutate( full_title = paste0("S", season_num, ":",  season_title)) |>
  ggplot() +
  geom_point(aes(x = full_title, y = air_date_first_ep )) + 
  coord_flip()

p

# Season timeline - order by season number ---------------------------------------------------------

p <- power_rangers_seasons |>
  mutate( full_title = paste0("S", season_num, ":",  season_title)) |>
  arrange(season_num) |>
  mutate( full_title = factor(full_title, levels = full_title)) |>
  ggplot() +
  geom_point(aes(x = full_title, y = air_date_first_ep )) + 
  coord_flip()

p

# Season timeline - descending order ---------------------------------------------------------

p <- power_rangers_seasons |>
  mutate( full_title = paste0("S", season_num, ":",  season_title)) |>
  arrange(-season_num) |>
  mutate( full_title = factor(full_title, levels = full_title)) |>
  ggplot() +
  geom_point(aes(x = full_title, y = air_date_first_ep )) + 
  coord_flip()

p 

# Season timeline - add last episode date ---------------------------------------------------------

p <- p + 
  geom_point(aes(x = full_title, y = air_date_last_ep_date))

p

# Season timeline - add segment ---------------------------------------------------------

p <- p + geom_segment(aes(x = full_title ,
                          y = air_date_first_ep,
                          
                          xend = full_title,
                          yend = air_date_last_ep_date)
                      )
p

# Season timeline -  color by producer ---------------------------------------------------------

power_rangers_seasons |>
  mutate( full_title = paste0("S", season_num, ":",  season_title)) |>
  arrange(-season_num) |>
  mutate( full_title = factor(full_title, levels = full_title)) |>
  ggplot(aes(color = producer)) +
  geom_point(aes(x = full_title, y = air_date_first_ep )) + 
  coord_flip()+
  geom_point(aes(x = full_title, y = air_date_last_ep_date))+
  geom_segment(aes(y = air_date_first_ep,
                   x = full_title ,
                   yend = air_date_last_ep_date,
                   xend = full_title))

# Season timeline -  size by number of episodes ---------------------------------------------------------

p <- power_rangers_seasons |>
  mutate( full_title = paste0("S", season_num, ":",  season_title)) |>
  arrange(-season_num) |>
  mutate( full_title = factor(full_title, levels = full_title)) |>
  ggplot(aes(color = producer)) +
  geom_point(aes(x = full_title, y = air_date_first_ep , size = number_of_episodes)) + 
  coord_flip()+
  geom_point(aes(x = full_title, y = air_date_last_ep_date, size = number_of_episodes))+
  geom_segment(aes(y = air_date_first_ep,
                   x = full_title ,
                   yend = air_date_last_ep_date,
                   xend = full_title))

  theme_set(theme_minimal())

# Season timeline -  adapt colours ---------------------------------------------------------
p <- p + 
  scale_color_manual(values = pr_cols2)

p

# Season timeline -  name labs  ---------------------------------------------------------
p <- p + 
  labs(title = "Power Rangers timeline", 
       x = "", 
       y = "", 
       size = "Number of episodes",
       color = "Producer") 
p

# Season timeline -  move legend  ---------------------------------------------------------
p <- p + 
  theme(legend.position = 'top') 
p

ggsave("tidytuesday-plot.png", p)

# Violin - IMDB rating per episode ----------------------------------------
p2 <- pr_df |>
  ggplot(aes(x = as.factor(season_num), y = IMDB_rating))+
  geom_violin(color = "darkgray")+
  geom_jitter(aes( fill = total_votes, color = total_votes ),
              shape = 21, alpha = 0.6, size = 3)+
  scale_fill_gradient2( low = pr_cols[5], 
                        mid = pr_cols[1], 
                        high = pr_cols[2],
                        midpoint = max(power_rangers_episodes$total_votes)/2,
                        limits = c(0, 
                                   max(power_rangers_episodes$total_votes))) + 
  scale_color_gradient2(low = pr_cols[5], 
                        mid = pr_cols[1], 
                        high = pr_cols[2],
                        midpoint = max(power_rangers_episodes$total_votes)/2,
                        limits = c(0, 
                                   max(power_rangers_episodes$total_votes))) + 
  labs(title = "IMDB rating episodes'distribution by season", 
       #subtitle = "Bubbles represent number of episodes",
       x = "Season number", 
       y = "IMDB rating", 
       color = "Number of votes",
       fill = "Number of votes") 

 p2 + geom_point(data = power_rangers_seasons, 
           mapping = aes(x = as.factor(season_num),
               y = season_IMDB_rating),
           size = 5,
           shape = 18,
           color = pr_cols[4])


# WordCloud from episode description  -------------------------------------
 
words_desc <- power_rangers_episodes |>
   select(episode_num, desc, season_title, episode_title) |>
   tidytext::unnest_tokens(output = word, input = desc) |>  # remove punctuation, convert to lower-case, separate all words
   anti_join(tidytext::stop_words, by = "word") |>  # remove stop words
   mutate(word = textstem::lemmatize_words(word)) |>
   count(word)|>
   arrange(-n)
  
  
  set.seed(12345)
  wordcloud2::wordcloud2(words_desc[1:600,],  color = rep(pr_cols,5))

# WordCloud from episode names  -------------------------------------
  
  words_eptitle <- power_rangers_episodes |>
    select(episode_num, desc, season_title, episode_title) |>
    tidytext::unnest_tokens(output = word, input = episode_title) |>  # remove punctuation, convert to lower-case, separate all words
    anti_join(tidytext::stop_words, by = "word") |>  # remove stop words
    mutate(word = textstem::lemmatize_words(word)) |>
    dplyr::filter(!str_detect(word, "[0-9]+")) |>
    count(word)|>
    arrange(-n)
  
  
  set.seed(12345)
  wordcloud2::wordcloud2(words_eptitle[1:60,],  color = rep(pr_cols,5))

# Top episode per season --------------------------------------------------
  pr_df <- 
    pr_df |>
    group_by(season_title) |>
    mutate(ranking_imdb = dense_rank(desc(IMDB_rating)),
             ranking_votes = dense_rank(desc(total_votes)),
             ) |> 
    ungroup() 
  
  # distribution of IMDB ratings, one colored
  pr_df |>
    mutate(top_rank = ifelse(season_num == 2 & ranking_imdb == 1, 1, 0 )) |>
    ggplot(aes(y= IMDB_rating, x = total_votes))+
    geom_jitter(aes(color = as.factor(top_rank), 
                   fill = as.factor(top_rank),
                   size = as.factor(top_rank)),
                show.legend=FALSE,
                shape = 21, alpha = 0.6, size = 4)+
    scale_color_manual(values = c("darkgray", pr_cols[1])) + 
    scale_fill_manual(values = c("darkgray", pr_cols[1])) +
    labs(title = "IMDB rating by number of votes", 
          #subtitle = "Bubbles represent number of episodes",
          x = "Number votes", 
          y = "IMDB rating")
    
# denisty plot   
set.seed(12345)

    pr_df |>
    ggplot() +
    geom_density(aes(x =  IMDB_rating), color = "darkgray") +
    geom_jitter( data = filter(pr_df, season_num == 1 & ranking_imdb == 1),
                mapping = aes(y= 0.2, x =  IMDB_rating),
                color = pr_cols[1],
                fill = pr_cols[1],
                show.legend=FALSE,
                shape = 21, 
                alpha = 0.6, 
                size = 6, 
                width = 0,
                height = 0.1)+
    labs(title = "IMDB ratings", 
         x = "",
         y = "") +
    theme(axis.text.y = element_blank(),
          panel.grid.major.y = element_blank())


  # density plot votes   
    set.seed(12345)
    
    pr_df |>
      ggplot() +
      geom_density(aes(x =  total_votes), color = "darkgray") +
      geom_jitter( data = filter(pr_df, season_num == 1 & ranking_votes == 1),
                   mapping = aes(y= 0, x =  total_votes),
                   color = pr_cols[2],
                   fill = pr_cols[2],
                   show.legend=FALSE,
                   shape = 21, 
                   alpha = 0.6, 
                   size = 6, 
                   width = 0,
                   height = 0.0001)+
      labs(title = "Total number of votes", 
           x = "",
           y = "") +
      theme(axis.text.y = element_blank(),
            panel.grid.major.y = element_blank())
    







# Live coding R Cafe 12 September 2024        
summary(power_rangers_seasons)

pr_df<-
  power_rangers_episodes |>
  inner_join(power_rangers_seasons|>
               rename(s_IMDB_rating = IMDB_rating),
             by ="season_title")
pr_df |>
  ggplot() +
  geom_boxplot(aes(x = air_date,
                   y = IMDB_rating,
                   color = producer)
               )+
  geom_jitter(aes(x = air_date, 
                  y = IMDB_rating, 
                  color = producer))+
  geom_point(data = power_rangers_seasons,
             aes(x = air_date_first_ep,
                 y = IMDB_rating),
             color = "black",
            size = 5) #+
  #geom_text(data = power_rangers_seasons , 
  #              aes(x = ))
    
    # +
    #   geom_point(data = power_rangers_seasons, 
    #              aes(x = air_date_last_ep_date, y = IMDB_rating ), 
    #              color = "black" )+
    #   geom_segment(data = power_rangers_seasons, 
    #                aes(x =air_date_first_ep ,
    #                    xend = air_date_last_ep_date,
    #                    y = IMDB_rating,
    #                    yend = IMDB_rating))
    
    
