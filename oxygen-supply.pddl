(define (domain oxygen-supply-destribution)

  (:requirements 
    :strips                 ; basic preconditions and effects
    :negative-preconditions ; to use not in preconditions
    :typing
  )

  (:types
    location air_transport road_transport - object
    hospital factory airport - location
    airplane - air_transport
    local_truck intercity_truck - road_transport
  )

  (:predicates
    (connected_road ?x ?y - location)
    (connected_airway ?x ?y - location)
    (oxygen_location ?fact - factory ?x - location)
  )

  (:functions
    (num_patients ?h - hospital)
    (oxygen_per_person)
    (carrying ?t)
    (hospital_oxygen ?h - hospital)
    (payload)
    (required_oxygen ?h - hospital)
    (daily_oxygen_volume_produced_per_machine ?f - factory)
    (num_machines ?f - factory)
    (fact_oxygen_production_capacity ?f - factory)
    (distance ?x ?y - location)
  )

  (:action oxygen_production_capacity
      :parameters (?f - factory)
      :precondition (and 
        (> (daily_oxygen_volume_produced_per_machine ?f) 0)
        (> (num_machines ?f) 0)
      )
      :effect (and 
        (assign (fact_oxygen_production_capacity ?f) (* (daily_oxygen_volume_produced_per_machine ?f) (num_machines ?f)))
      )
  )

  (:action calculate_oxygen_required
      :parameters (?h - hospital)
      :precondition (and 
        (> (num_patients ?h) 0)
        (> (oxygen_per_person) 0)
      )
      :effect (and 
        (assign (required_oxygen ?h) (* (num_patients ?h) (oxygen_per_person)))
      )
  )

  (:action load_oxygen_transportation
    :parameters (?f - factory ?h - hospital)
    :precondition (and      
      (>= (fact_oxygen_production_capacity ?f) (required_oxygen ?h))   
    )
    :effect (and 
      (assign (payload) (required_oxygen ?h))
      (oxygen_location ?f ?f)
    )
  )

  (:action transport_truck_local
   :parameters (?x ?y - location ?h - hospital ?f - factory ?t - local_truck)
   :precondition (and
      (< (hospital_oxygen ?h) (required_oxygen ?h))
      (connected_road ?x ?y)
      (<= (distance ?x ?y) 100)
      (oxygen_location ?f ?x)
      (> (payload) 0)
    )
   :effect (and
  		(assign (carrying ?t) (payload))
      (not(oxygen_location ?f ?x))
      (oxygen_location ?f ?y)
    )
  )

  (:action transport_truck_intercity
   :parameters (?x ?y - location ?h - hospital ?f - factory ?t - intercity_truck)
   :precondition (and 
      (< (hospital_oxygen ?h) (required_oxygen ?h))
      (connected_road ?x ?y)
      (> (distance ?x ?y) 100)
      (< (distance ?x ?y) 500)
      (oxygen_location ?f ?x)
      (> (payload) 0)
    )
   :effect (and
  		(assign (carrying ?t) (payload))
      (not(oxygen_location ?f ?x))
      (oxygen_location ?f ?y)
    )
  )

  (:action transport_plane
   :parameters (?x ?y - location ?h - hospital ?f - factory ?t - airplane)
   :precondition (and
      (< (hospital_oxygen ?h) (required_oxygen ?h))
      (connected_airway ?x ?y)
      (> (distance ?x ?y) 500)
      (oxygen_location ?f ?x)
      (> (payload) 0)
    )
   :effect (and
  		(assign (carrying ?t) (payload))
      (not(oxygen_location ?f ?x))
      (oxygen_location ?f ?y)
    )
  )

  (:action deliver_oxygen
    :parameters (?f - factory ?h - hospital ?t - road_transport)
    :precondition (and
      (< (hospital_oxygen ?h) (required_oxygen ?h))
      (> (carrying ?t) 0)
      (oxygen_location ?f ?h)
    )
    :effect (and
      (assign (hospital_oxygen ?h) (carrying ?t))
      (assign (carrying ?t) 0) 
    ) 
  )

)