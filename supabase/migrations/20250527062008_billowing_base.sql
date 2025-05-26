/*
  # Create database schema for Lotus Lions

  1. New Tables
    - `players`
      - `id` (uuid, primary key)
      - `name` (text)
      - `surname` (text)
      - `position` (text)
      - `image_url` (text)
      - `description` (text)
    
    - `scheduled_games`
      - `id` (uuid, primary key)
      - `opponent` (text)
      - `game_date` (timestamptz)
      - `location` (text)
      - `is_home_game` (boolean)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to manage data
*/

-- Players table
CREATE TABLE IF NOT EXISTS players (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  surname text NOT NULL,
  position text NOT NULL,
  image_url text NOT NULL,
  description text,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can view players"
  ON players
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Only authenticated users can manage players"
  ON players
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Scheduled games table
CREATE TABLE IF NOT EXISTS scheduled_games (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  opponent text NOT NULL,
  game_date timestamptz NOT NULL,
  location text NOT NULL,
  is_home_game boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE scheduled_games ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can view scheduled games"
  ON scheduled_games
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Only authenticated users can manage scheduled games"
  ON scheduled_games
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');