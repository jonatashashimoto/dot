
/* FULLSCREEN */

setHandler ( 'm', HYPER_SHIFT, () => {

  const window = Window.focused ();

  if ( !window ) return;

    // window.maximise()
  window.setFullScreen ( !window.isFullScreen () );

});
