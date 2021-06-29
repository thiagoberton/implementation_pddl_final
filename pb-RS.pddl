(define (problem pb-Passo_Fundo_Region)
    (:domain oxygen-supply-destribution)

    (:objects 
        truck_local - local_truck
        truck_intercity - intercity_truck
        Boeing_747 - airplane
        HSVP_Passo_Fundo HCC_Carazinho HCR_Marau HSL_Porto_Alegre - hospital
        factory_Porto_Alegre factory_Sao_Paulo - factory
        CGH_Sao_Paulo POA_Porto_Alegre - airport

    )

    (:init
        ;connections (km)
        (connected_road factory_Porto_Alegre HSVP_Passo_Fundo)
        (= (distance factory_Porto_Alegre HSVP_Passo_Fundo) 289)

        (connected_road factory_Sao_Paulo HSVP_Passo_Fundo)
        (= (distance factory_Sao_Paulo HSL_Porto_Alegre) 989)

        (connected_road  factory_Porto_Alegre HCC_Carazinho)
        (= (distance factory_Porto_Alegre HCC_Carazinho) 290)

        (connected_road factory_Sao_Paulo HCC_Carazinho)
        (= (distance factory_Sao_Paulo HCC_Carazinho) 1033)

        (connected_road  factory_Porto_Alegre HCR_Marau)
        (= (distance factory_Porto_Alegre HCR_Marau) 270)

        (connected_road factory_Sao_Paulo HCR_Marau)
        (= (distance factory_Sao_Paulo HCR_Marau) 975)

        (connected_road factory_Sao_Paulo CGH_Sao_Paulo)
        (= (distance factory_Sao_Paulo CGH_Sao_Paulo) 40)

        (connected_airway CGH_Sao_Paulo POA_Porto_Alegre)
        (= (distance CGH_Sao_Paulo POA_Porto_Alegre) 840)

        (connected_road POA_Porto_Alegre HSL_Porto_Alegre)
        (= (distance POA_Porto_Alegre HSL_Porto_Alegre) 20)

        (connected_road factory_Sao_Paulo HSL_Porto_Alegre)
        (= (distance factory_Sao_Paulo HSL_Porto_Alegre) 1135)

        ;volume (m3)
        (= (daily_oxygen_volume_produced_per_machine factory_Porto_Alegre) 1200)
        (= (num_machines factory_Porto_Alegre) 22)

        (= (daily_oxygen_volume_produced_per_machine factory_Sao_Paulo) 2280)
        (= (num_machines factory_Sao_Paulo) 35)

        (= (num_patients HSL_Porto_Alegre) 180) ;54000
        (= (num_patients HSVP_Passo_Fundo) 80) 
        (= (num_patients HCC_Carazinho) 20)
        (= (num_patients HCR_Marau) 60)
        

        (= (hospital_oxygen HSVP_Passo_Fundo) 0)
        (= (hospital_oxygen HCC_Carazinho) 0)
        (= (hospital_oxygen HCR_Marau) 0)
        (= (hospital_oxygen HSL_Porto_Alegre) 0)

        (= (oxygen_per_person) 300)
    )

    (:goal (and
        (= (hospital_oxygen HSL_Porto_Alegre) (required_oxygen HSL_Porto_Alegre))
        (= (hospital_oxygen HSVP_Passo_Fundo) (required_oxygen HSVP_Passo_Fundo))
        (= (hospital_oxygen HCC_Carazinho) (required_oxygen HCC_Carazinho))
        (= (hospital_oxygen HCR_Marau) (required_oxygen HCR_Marau))
        )
    )
)


