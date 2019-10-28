/* global getAssetRegistry getFactory emit */

/**
 * Collect temperatures.
 * Expects two values: temperature label and its value.
 * @param {org.example.basic.Collect} tx
 * @transaction
 */
async function Collect(tx) {
  let factory = getFactory();
  let assetRegistry = await getAssetRegistry('org.example.basic.Temperature');
  try{
    // check if the asset is existing ?
    let t = await assetRegistry.get(tx.temperature);
    t.value = tx.newValue;
    await assetRegistry.update(t);
  } catch(e) {
    // the asset doesn't exist!
    let nt = factory.newResource('org.example.basic', 'Temperature', tx.temperature);
    nt.value = tx.newValue;
    await assetRegistry.add(nt);
  }
}

/**
 * Set the dynamic constant to play the role of temperature threshold.
 * Expects two values: DynCst name and its value.
 * @param {org.example.basic.Set} tx
 * @transaction
 */
async function Set(tx) {
  let factory = getFactory();
  let assetRegistry = await getAssetRegistry('org.example.basic.DynCst');
  try{
    // check if the asset is existing ?
    let cst = await assetRegistry.get(tx.name);
    cst.value = tx.newValue;
    await assetRegistry.update(cst);
  } catch(e) {
    // the asset doesn't exist!
    let ncst = factory.newResource('org.example.basic', 'DynCst', tx.name);
    ncst.value = tx.newValue;
    await assetRegistry.add(ncst);
  }
}

/**
 * Check if the temperature threshold 'Threshold_T' is exceeded to notify the outside world with an event.
 * Expects two values: DynCst name and its value.
 * @param {org.example.basic.Notify} tx
 * @transaction
 */
async function Notify(tx) {
  let factory = getFactory();
  let cstRegistry = await getAssetRegistry('org.example.basic.DynCst');
  let tRegistry = await getAssetRegistry('org.example.basic.Temperature');
  let T = await cstRegistry.get('Threshold_Tabc');		//Dynamic Constant
  let t = await tRegistry.get(tx.temperature);
  let msg_ok = "Fine ("+String(t.value)+").";
  let msg_err = "Exceeded threshold '"+String(T.name)+"' by temperature '"+String(tx.temperature)+"' ("+String(t.value)+" > "+String(T.value)+").";
  if(Number(t.value) > Number(T.value)) {
    let event = getFactory().newEvent('org.example.basic', 'TemperatureExceeded');
    event.msg = msg_err;
    emit(event); 
  }
}





