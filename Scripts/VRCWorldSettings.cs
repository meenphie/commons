
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class VRCWorldSettings : UdonSharpBehaviour
{
    [SerializeField] private float jumpHeight = 3f;
    [SerializeField] private float runSpeed = 4f;
    [SerializeField] private float walkSpeed = 2f;
    [SerializeField] private float strafeSpeed = 2f;
    [SerializeField] private float gravity = 1f;

    private void Start()
    {
        var localPlayer = Networking.LocalPlayer;

        if (Utilities.IsValid(localPlayer))
        {
            localPlayer.SetJumpImpulse(jumpHeight);
            localPlayer.SetRunSpeed(runSpeed);
            localPlayer.SetWalkSpeed(walkSpeed);
            localPlayer.SetStrafeSpeed(strafeSpeed);
            localPlayer.SetGravityStrength(gravity);
        }

        enabled = false;
    }
}
