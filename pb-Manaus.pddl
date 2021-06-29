(define (problem pb-Manaus)
    (:domain oxygen-supply-destribution)

    (:objects 
        truck_local - local_truck 
        truck_intercity - intercity_truck
        C-130_Hercules - airplane
        Hospital_Universitario_Getulio_Vargas - hospital
        White_Martins_Belem White_Martins_Manaus - factory
        Air_Force_base_ALA_9-Belem Air_Force_base_ALA_8-Manaus - airport
    )

    (:init
        ;connections (km)
        (connected_road White_Martins_Belem Air_Force_base_ALA_9-Belem)
        (= (distance White_Martins_Belem Air_Force_base_ALA_9-Belem) 6)

        (connected_airway Air_Force_base_ALA_9-Belem Air_Force_base_ALA_8-Manaus)
        (= (distance Air_Force_base_ALA_9-Belem Air_Force_base_ALA_8-Manaus) 1298)

        (connected_road Air_Force_base_ALA_9-Belem Air_Force_base_ALA_8-Manaus)
        (= (distance Air_Force_base_ALA_9-Belem Air_Force_base_ALA_8-Manaus) 3040)
        
        (connected_road Air_Force_base_ALA_8-Manaus Hospital_Universitario_Getulio_Vargas)
        (= (distance Air_Force_base_ALA_8-Manaus Hospital_Universitario_Getulio_Vargas) 5.5)

        (connected_road White_Martins_Manaus Hospital_Universitario_Getulio_Vargas)
        (= (distance White_Martins_Manaus Hospital_Universitario_Getulio_Vargas) 10.9)

        ;volume (m3)
        (= (daily_oxygen_volume_produced_per_machine White_Martins_Belem) 4800)
        (= (num_machines White_Martins_Belem) 30)

        (= (daily_oxygen_volume_produced_per_machine White_Martins_Manaus) 2450)
        (= (num_machines White_Martins_Manaus) 15)

        (= (num_patients Hospital_Universitario_Getulio_Vargas) 220)
        
        (= (hospital_oxygen Hospital_Universitario_Getulio_Vargas) 0)

        (= (oxygen_per_person) 300)
    )

    (:goal (and
        (= (hospital_oxygen Hospital_Universitario_Getulio_Vargas) (required_oxygen Hospital_Universitario_Getulio_Vargas))
        )
    )
)
