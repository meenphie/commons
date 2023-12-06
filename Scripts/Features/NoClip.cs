
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using VRC.Udon.Common;

namespace Fairplex.Commons
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class NoClip : UdonSharpBehaviour
    {
        [SerializeField] private Transform target;
        private VRCPlayerApi localPlayer;
        private float inputMoveVertical;
        private Vector3 targetPos;
        private Quaternion targetRotation;


        private void OnEnable()
        {
            localPlayer = Networking.LocalPlayer;
            localPlayer.SetVelocity(Vector3.zero);
        }

        public override void InputMoveVertical(float value, UdonInputEventArgs args)
        {
            if (args.handType == HandType.LEFT)
            {
                inputMoveVertical = value;
            }
        }

        private void FixedUpdate()
        {
            if (inputMoveVertical == 0) return;

            var playerPosition = localPlayer.GetPosition();
            var playerRotation = localPlayer.GetRotation();
            var headRotation = localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).rotation;

            if (inputMoveVertical >= 0.1f)
            {
                targetRotation = headRotation;
            }
            else if (inputMoveVertical <= 0.1f)
            {
                targetRotation = Quaternion.LookRotation(-transform.forward, Vector3.up);
            }

            transform.SetPositionAndRotation(playerPosition, targetRotation);

            localPlayer.TeleportTo(target.position, playerRotation);
        }
    }
}