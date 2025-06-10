```mermaid
erDiagram
    profil ||--o{ stats : have
    profil ||--o{ friend_relation : is_friend
    profil ||--o{ friend_relation : is_requester
    modules ||--o{ sequences : contain
    profil ||--o{ posts : difuse
    stats ||--o{ posts : difuse_with
    users_supabase ||--o{ profil : have
    users_supabase{
        string id
        string uuid
    }
    profil {
        int id
        String firstName
        String lastName
        String email
        String phone
        String avatar
        String bio
        String password
        String roles
        int nbrStick
    }
    stats {
        int id
        String time
        double distance
        double speed
        int id_user
        DateTime date
    }
    friend_relation {
        int id
        string friendName
        string requesterName
        int friendId
        int requesterId
    }
    posts{
        int id
        string post
        int idStats
        int idUserWhoPost
    }
    sequences{
        int id 
        string titleSequences
        json descriptionSequences
        int duration
        int numberOfCircuit 
        int idModule
    }
    modules{
        int id
        string titleModule
    }
```