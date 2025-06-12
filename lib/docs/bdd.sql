CREATE TABLE public.profil (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  "firstName" character varying NOT NULL,
  "lastName" character varying NOT NULL,
  email character varying NOT NULL,
  phone character varying DEFAULT '''NULL''::character'::character varying,
  bio text DEFAULT 'NULL'::text,
  roles character varying NOT NULL DEFAULT 'user'::character varying,
  "nbrStick" bigint NOT NULL DEFAULT '0'::bigint,
  "userUuid" uuid NOT NULL DEFAULT auth.uid(),
  avatar character varying DEFAULT 'avatar.png'::character varying,
  CONSTRAINT profil_pkey PRIMARY KEY (id),
  CONSTRAINT "Profil_userUuid_fkey" FOREIGN KEY ("userUuid") REFERENCES auth.users(id)
);
CREATE TABLE public.stats (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  distance real,
  speed real,
  date text,
  "idUser" bigint,
  time real,
  CONSTRAINT stats_pkey PRIMARY KEY (id),
  CONSTRAINT "stats_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES public.profil(id)
);
CREATE TABLE public."friend-relation" (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  "friendId" bigint,
  "requesterId" bigint,
  CONSTRAINT "friend-relation_pkey" PRIMARY KEY (id),
  CONSTRAINT "friend-relation_friendId_fkey" FOREIGN KEY ("friendId") REFERENCES public.profil(id),
  CONSTRAINT FriendRelation_requestertId_fkey FOREIGN KEY ("requesterId") REFERENCES public.profil(id)
);
CREATE TABLE public.modules (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  "titleModule" character varying NOT NULL,
  objectif character varying,
  materiel character varying,
  CONSTRAINT modules_pkey PRIMARY KEY (id)
);
CREATE TABLE public.posts (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  post character varying DEFAULT ''::character varying,
  idStats bigint,
  "idUserWhoPost" bigint,
  CONSTRAINT posts_pkey PRIMARY KEY (id),
  CONSTRAINT posts_idStats_fkey FOREIGN KEY (idStats) REFERENCES public.stats(id),
  CONSTRAINT "posts_idUserWhoPost_fkey" FOREIGN KEY ("idUserWhoPost") REFERENCES public.profil(id)
);
CREATE TABLE public.sequences (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  "titleSequences" character varying NOT NULL,
  "descriptionSequences" json,
  duration smallint,
  "numberOfCircuit" smallint,
  "idModule" bigint,
  CONSTRAINT sequences_pkey PRIMARY KEY (id),
  CONSTRAINT "sequences_idModule_fkey" FOREIGN KEY ("idModule") REFERENCES public.modules(id)
);

create or replace function public.create_user_profile()
returns trigger as $$
declare
  _firstName text;
  _lastName text;
begin
  _firstName := new.raw_user_meta_data->>'firstName';
  _lastName := new.raw_user_meta_data->>'lastName';

  insert into public.profil ("userUuid", email, "firstName", "lastName")
  values (new.id, new.email, _firstName, _lastName);
  return new;
end;
$$ language plpgsql security definer;



INSERT INTO "public"."modules" ( "titleModule", "objectif", "materiel") VALUES ('FULL BODY', 'Solliciter tous les grands groupes musculaires.', 'Tapis, haltères légers, élastiques.'), ('Abdos', 'Travailler sangle abdominale, gainage et posture.', 'Tapis, Swiss ball (facultatif)'), ('Jambes & Fessiers', 'Renforcer les muscles inférieurs.', 'Haltères, bandes élastiques.'), ('Haut du corps', 'Développer la force et la posture.', 'Haltères, bandes, tapis.'), ('HIIT', 'Mélanger force et endurance.', 'Aucun ou charge légère.');
INSERT INTO "public"."sequences" ("titleSequences", "descriptionSequences", "duration", "numberOfCircuit", "idModule") VALUES ('WARMUP', '["2 MIN DE MARCHE ACTIVE", "2 MIN DE JUMPING JACKS", "1 MIN DE SQUATS SANS CHARGE"]', '5', '1', '1'), ( 'FULL BODY CIRCUIT', '["30 SEC DE SQUATS", "30 SEC DE POMPES", "30 SEC DE GAINAGE", "30 SEC DE FENTES ALTERNÉES", "REPOS 30 SEC", "RÉPÉTER 3 FOIS"]', '20', '4', '1'), ( 'COOLDOWN', '["1 MIN D’ÉTIREMENT DES QUADRICEPS", "1 MIN D’ÉTIREMENT DES PECTORAUX", "1 MIN D’ÉTIREMENT DES ISCHIOS", "RESPIRATION CONTRÔLÉE 1 MIN"]', '5', '1', '1'), ('WARMUP', '["2 MIN DE ROTATION DU TRONC", "1 MIN DE GAINAGE DYNAMIQUE", "1 MIN DE MOUNTAIN CLIMBERS"]', '4', '1', '2'), ('CORE STRENGTH', '["45 SEC DE PLANCHA", "30 SEC DE CRUNCHS", "30 SEC DE RELEVÉS DE JAMBES", "30 SEC DE RUSSIAN TWISTS", "15 SEC DE REPOS", "RÉPÉTER 4 FOIS"]', '18', '4', '2'), ('COOLDOWN', '["ÉTIREMENT DU DOS 1 MIN", "ÉTIREMENT DES ABDOS 1 MIN", "RESPIRATION PROFONDE 1 MIN"]', '3', '1', '2'), ('WARMUP', '["2 MIN DE TALONS-FESSES", "2 MIN DE SQUATS RAPIDES", "1 MIN DE FENTES SANS CHARGE"]', '5', '1', '3'), ('LEGS & GLUTES CIRCUIT', '["20 SQUATS", "15 FENTES PAR JAMBE", "20 RELEVÉS DE BASSIN", "15 SAUTS VERTICAUX", "REPOS 1 MIN", "RÉPÉTER 3 FOIS"]', '22', '3', '3'), ('COOLDOWN', '["ÉTIREMENT DES QUADRICEPS", "ÉTIREMENT DES FESSIERS", "ÉTIREMENT DES MOLLETS", "1 MIN DE RESPIRATION"]', '5', '1', '3'), ('WARMUP', '["1 MIN DE ROTATIONS D’ÉPAULES", "1 MIN DE PETITES POMPES", "1 MIN DE MOUVEMENTS DE BRAS"]', '3', '1', '4'), ('UPPER BODY WORKOUT', '["15 POMPES", "10 POMPES DIAMANT", "20 SEC DE GAINAGE LATÉRAL PAR CÔTÉ", "10 BURPEES", "REPOS 45 SEC", "RÉPÉTER 3 FOIS"]', '20', '3', '4'), ('COOLDOWN', '["ÉTIREMENT DES BRAS", "ÉTIREMENT DES ÉPAULES", "RESPIRATION CONTRÔLÉE 1 MIN"]', '4', '1', '4'), ('WARMUP', '["2 MIN DE COURSE SUR PLACE", "2 MIN DE MOUNTAIN CLIMBERS", "1 MIN DE JUMPING JACKS"]', '5', '1', '5'), ('HIIT BLAST', '["20 SEC DE BURPEES", "20 SEC DE SQUATS SAUTÉS", "20 SEC DE POMPES", "20 SEC DE GAINAGE DYNAMIQUE", "10 SEC DE PAUSE", "RÉPÉTER 4 FOIS"]', '16', '4', '5'), ('COOLDOWN', '["2 MIN DE RESPIRATION LENTE", "1 MIN D’ÉTIREMENT GLOBAL"]', '3', '1', '5');
