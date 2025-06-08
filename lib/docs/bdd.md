```mermaid
erDiagram
    PROFIL ||--o{ STATS : has
    PROFIL ||--o{ FRIENDRELATION : is_friend
    PROFIL ||--o{ FRIENDRELATION : is_requester
    PROFIL {
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
    STATS {
        int id
        String time
        int distance
        int speed
        String location
        int id_user
        DateTime date
    }
    FRIENDRELATION {
        int id
        string friendName
        string requesterName
        int friendId
        int requesterId
    }
```