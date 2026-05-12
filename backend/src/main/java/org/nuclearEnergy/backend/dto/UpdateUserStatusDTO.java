package org.nuclearEnergy.backend.dto;


import lombok.Data;
import lombok.NonNull;

@Data
public class UpdateUserStatusDTO {

    @NonNull
    private Integer status;

}
