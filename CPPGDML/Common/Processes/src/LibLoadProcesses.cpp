//
#include "Saxana/SAXComponentFactory.h"

extern "C" {

  void GDMLProcessLibLoad() {
    LOAD_COMPONENT(defineProcess)
    LOAD_COMPONENT(constantProcess)
    LOAD_COMPONENT(quantityProcess)
    LOAD_COMPONENT(expressionProcess)
    LOAD_COMPONENT(positionProcess)
    LOAD_COMPONENT(rotationProcess)
    LOAD_COMPONENT(atomProcess)
    LOAD_COMPONENT(DProcess)
    LOAD_COMPONENT(DrefProcess)
    LOAD_COMPONENT(TProcess)
    LOAD_COMPONENT(TrefProcess)
    LOAD_COMPONENT(PProcess)
    LOAD_COMPONENT(PrefProcess)
    LOAD_COMPONENT(isotopeProcess)
    LOAD_COMPONENT(elementProcess)
    LOAD_COMPONENT(materialProcess)
    LOAD_COMPONENT(fractionProcess)
    LOAD_COMPONENT(compositeProcess)    
    LOAD_COMPONENT(firstProcess)    
    LOAD_COMPONENT(secondProcess)    
    LOAD_COMPONENT(positionrefProcess)    
    LOAD_COMPONENT(rotationrefProcess)    
    LOAD_COMPONENT(unionProcess)    
    LOAD_COMPONENT(subtractionProcess)    
    LOAD_COMPONENT(intersectionProcess)
    LOAD_COMPONENT(boxProcess)    
    LOAD_COMPONENT(sphereProcess)    
    LOAD_COMPONENT(tubeProcess)    
    LOAD_COMPONENT(paraProcess)    
    LOAD_COMPONENT(coneProcess)    
    LOAD_COMPONENT(trdProcess)    
    LOAD_COMPONENT(polyconeProcess)    
    LOAD_COMPONENT(zplaneProcess)    
    LOAD_COMPONENT(trapProcess)
    LOAD_COMPONENT(hypeProcess)
    LOAD_COMPONENT(torusProcess)
    LOAD_COMPONENT(orbProcess)
    LOAD_COMPONENT(polyhedraProcess)
    LOAD_COMPONENT(eltubeProcess)
    LOAD_COMPONENT(volumeProcess)
    LOAD_COMPONENT(assemblyProcess)
    LOAD_COMPONENT(physvolProcess)
    LOAD_COMPONENT(replicavolProcess)
    LOAD_COMPONENT(paramvolProcess)
    LOAD_COMPONENT(paramalgProcess)
    LOAD_COMPONENT(parametersProcess)
    LOAD_COMPONENT(parameterised_position_sizeProcess)
    LOAD_COMPONENT(box_dimensionsProcess)
    LOAD_COMPONENT(tube_dimensionsProcess)
    LOAD_COMPONENT(materialrefProcess)    
    LOAD_COMPONENT(solidrefProcess)    
    LOAD_COMPONENT(volumerefProcess)
    LOAD_COMPONENT(worldProcess)    
    LOAD_COMPONENT(setupProcess)    
  }

};